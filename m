From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 02 Aug 2013 16:58:45 -0700
Subject: [PATCH v8] watchdog: Add MOXA ART watchdog driver
In-Reply-To: <1375454445-15589-1-git-send-email-jonas.jensen@gmail.com>
References: <1375101228-10930-1-git-send-email-jonas.jensen@gmail.com>
 <1375454445-15589-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <51FC47B5.5050103@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2013 07:40 AM, Jonas Jensen wrote:
> This patch adds a watchdog driver for the main hardware watchdog timer
> found on MOXA ART SoCs.
>
> The MOXA ART SoC provides one writable timer register, restarting
> the hardware once it reaches zero. The register is auto decremented
> every APB clock cycle.
>
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Still wondering where the requirement comes from not to use unlikely()
in probe functions. Must be one of those tribal knowledge things people
have been talking about.

Nevertheless, still

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter
