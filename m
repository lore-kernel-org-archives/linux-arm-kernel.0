From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Fri, 17 Aug 2012 17:28:41 +0200
Subject: mx27_3ds : Sound doesn't work anymore on linux-next
In-Reply-To: <502E6033.4010805@gmail.com>
References: <502E6033.4010805@gmail.com>
Message-ID: <502E6329.60308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just some more informations, process enter in D+ state and this is so 
impossible to kill them.
On 08/17/2012 05:16 PM, Ga?tan Carlier wrote:
> Hi,
> It is several days that I tried to make sound work on mx27_3ds platform
> from linux-next (daily cloned/pulled) but each time I try start start
> aplay or alsamixer, the process freeze and CTRL+C has not effect. I can
> open another SSH session and execute other commands but alsa commands
> always freeze.
> The sound card is correctly installer at boot :
>
> imx_mc13783 imx_mc13783.0:  mc13783-hifi <-> imx-ssi.0 mapping ok
> ALSA device list:
>    #0: imx_mc13783
>
> I only apply the patch "[PATCH 1/2] ARM: mx27pdk: Add audio support". I
> attach my config file.
>
> I try to apply patch on a previous commit when I told that this patch
> was working but it didn't succeed the is still freezing.
> I try to make it working on another mx27-based platform but same
> problem. I try to update Alsa from version 1.0.23 to 1.0.25 but same
> behaviour.
> What is wrong ?
>
> Regards,
> Ga?tan Carlier.

Regards,
Ga?tan.
