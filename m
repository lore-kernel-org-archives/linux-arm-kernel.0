From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 07 Feb 2016 12:16:55 +0100
Subject: [PATCH v2 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <20160207071747.GA14010@kroah.com> (Greg Kroah-Hartman's message
 of "Sat, 6 Feb 2016 23:17:47 -0800")
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
 <1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
 <20160207071747.GA14010@kroah.com>
Message-ID: <87a8nc3h3s.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,
 
 On dim., f?vr. 07 2016, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 03, 2016 at 07:41:20PM +0100, Gregory CLEMENT wrote:
>> +static struct console mvebu_uart_console = {
>> +	.name	= "ttyS",
>
> You aren't ttyS, that's a reserved name for a different chip, please use
> a new name and major/minor numbers.

Oh sorry, I changed the ttyS to ttyMV in the uart_driver struct but I
forgot the console. I will fix it in next version.

Thanks,

Gregory

>
> thanks,
>
> greg k-h

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
