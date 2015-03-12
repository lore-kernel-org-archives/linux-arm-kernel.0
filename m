From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 12 Mar 2015 09:22:50 -0700
Subject: [PATCH v5 04/10] watchdog: at91rm9200: implement restart handler
In-Reply-To: <1426162054-9987-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1426162054-9987-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150312162250.GB15121@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 01:07:28PM +0100, Alexandre Belloni wrote:
> Restarting the at91rm9200 is done through programming the watchdog and waiting
> for it to reset.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
