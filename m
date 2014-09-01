From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 01 Sep 2014 15:53:53 +0200
Subject: [linux-sunxi] [PATCH v2 0/4] input: Add new sun4i-lradc-keys
 driver
In-Reply-To: <CAGb2v66VZqpHyghs5xn=RdDUVU=2PxFw5BJ-R5Xpsk-nfoDM0Q@mail.gmail.com>
References: <1388656707-16181-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v66VZqpHyghs5xn=RdDUVU=2PxFw5BJ-R5Xpsk-nfoDM0Q@mail.gmail.com>
Message-ID: <54047A71.3070207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/01/2014 03:47 PM, Chen-Yu Tsai wrote:
> Hi Hans,
> 
> It seems this series didn't get any attention. Care to respin on top
> of the latest tree?
> 
> FYI, I have the series rebased on top of sunxi-next:
> https://github.com/wens/linux/commits/others/sunxi-lradc-input-v2

The problem is not it not getting attention, the problem is people were
unhappy with the dt-bindings for this. I've a pretty good idea of how
to fix up the bindings, but -ENOTIME so far. If you've a board you can
test this on and want to take a shot at fixing it up, I can get into
a little bit more detail.

Regards,

Hans
