From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 16 Sep 2015 23:10:15 -0700
Subject: [PATCH v2 3/3] ARM: brcmstb: Setup BIU control registers during
 boot
In-Reply-To: <1442340900-15320-4-git-send-email-f.fainelli@gmail.com>
References: <1442340900-15320-1-git-send-email-f.fainelli@gmail.com>
 <1442340900-15320-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <CADtm3G6LV+Xo+yKhCZBJpD+LE9GQHDAmSRu3FNWCanrzC5Ny3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 11:15 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Call brcmstb_biuctrl_init() in brcmstb's init_irq machine descriptor
> callback since we need to setup the Bus Interface Unit before SMP in
> particular, but we also need to be able to remap registers.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
