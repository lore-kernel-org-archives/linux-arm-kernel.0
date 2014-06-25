From: denis@eukrea.com (Denis Carikli)
Date: Wed, 25 Jun 2014 10:27:10 +0200
Subject: [PATCH v14 08/10] drm/panel: Add Eukrea mbimxsd51 displays.
In-Reply-To: <20140624220404.GA30155@mithrandir>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-8-git-send-email-denis@eukrea.com>
 <20140624214926.GA30039@mithrandir> <20140624235639.487429ad@e6520eb>
 <20140624220404.GA30155@mithrandir>
Message-ID: <53AA87DE.5030109@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 12:04 AM, Thierry Reding wrote:
>> because on this very simple display board, we only have DVI LVDS signals
>> without the I2C to detect the display.
>
> That's unfortunate. In that case perhaps a better approach would be to
> add a video timings node to the device that provides the DVI output?
I've just done that.

Should I resend now? The goal is to avoid as much as possible extra 
versions.

Also, as I said before in a response to "[PATCH v14 09/10] ARM: dts: 
mbimx51sd: Add display support.", the LCD regulator was inverted, it 
worked while inverted because of a bug which is now fixed by:
"imx-drm: parallel-display: Fix DPMS default state."

Right now, I don't have any other changes for this serie beside a simple 
rebase of "dts: imx5*, imx6*: correct display-timings rebased".

Denis.
