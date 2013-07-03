From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 3 Jul 2013 13:13:08 +0300
Subject: [PATCH v2 0/9] wilink: add device tree support
In-Reply-To: <1372776948-24840-1-git-send-email-coelho@ti.com>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
Message-ID: <CANOLnOPBHesTiV61zpQ_QS9c7E91K50EnbMnGhvgaViuA_3=Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 2, 2013 at 5:55 PM, Luciano Coelho <coelho@ti.com> wrote:
> Hi,
>
> This is a follow-up on a previous patch set that had a smaller
> audience.  This time, I added the lists and people who were involved
> in the review of the bindings documentation, since most of my changes
> in v2 are coming from discussions there.
>
> This patch series adds device tree support to the wlcore_sdio driver,
> which is used by WiLink6, WiLink7 and WiLink8.

Could you perhaps consider doing device tree conversion for wl1251
too? With the knowledge you have from working on this series, it would
be much easier for you to do it than for someone else, and I don't
have much hope someone will do it at all. It's WiLink series chip
after all. Without this pandora and N900 are going to lose wifi
support after the switch to dt-only kernel.

I can offer you my help testing things on pandora and I'm sure someone
here could try it on N900.


--
Gra?vydas
