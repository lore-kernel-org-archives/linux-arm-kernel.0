From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Fri, 07 Jun 2013 21:56:52 +0200
Subject: [RFC PATCH 28/50] ASoC: atmel-ssc: prepare clk before calling
 enable
In-Reply-To: <20130607165510.GA31367@sirena.org.uk>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370622370-19614-1-git-send-email-b.brezillon@overkiz.com>
 <20130607165510.GA31367@sirena.org.uk>
Message-ID: <51B23B04.20604@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2013 18:55, Mark Brown wrote:
> On Fri, Jun 07, 2013 at 06:26:09PM +0200, Boris BREZILLON wrote:
>> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
>> avoid common clk framework warnings.
>
> Applied since I happened to notice this on he list but you should
> *always* CC maintainers on patches otherwise they're likely to get
> missed.
>
I used get_mainainer script and it returns:

Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRI...)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC 
DRI...)
linux-kernel at vger.kernel.org (open list)

Please tell me if misuse this script or if I should use something else.

Best regards,

Boris

>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
