From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 03 Jul 2011 16:06:12 +0400
Subject: [PATCH V2 0/2] Suspend for gpio-vbus support
In-Reply-To: <1309615344-12714-1-git-send-email-dbaryshkov@gmail.com>
References: <1309615344-12714-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <4E105B34.3080908@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-07-2011 18:02, Dmitry Eremin-Solenikov wrote:

> Previous version of these patches generated quite a lot of comments.
> Now I'd like to present an updated version of this patchset.

> Changes since V1:
> * Switch to using dev_pm_ops instead of platform_driver hooks
> * Move suspend/resume to _noirq (LATE) to be sure that otg transceiver
>    suspends after the main UDC driver.

    Frankly speaking, I don't see where you have done that...

> Dmitry Eremin-Solenikov (2):
>        gpio-vbus: support disabling D+ pullup on suspend
>        mioa701: move gpio-pullup functionality to gpio-vbus

WBR, Sergei
