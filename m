From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 16 Mar 2015 20:55:35 -0700
Subject: [PATCH 26/35 linux-next] hwmon: constify of_device_id array
In-Reply-To: <1426535685-25996-5-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-5-git-send-email-fabf@skynet.be>
Message-ID: <5507A5B7.5020704@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2015 12:54 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---

Applied to hwmon-next.

Thanks,
Guenter
