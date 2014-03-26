From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 26 Mar 2014 14:09:35 +0900
Subject: [PATCH V2 1/5] ARM: shmobile: r8a7791: add IIC0/1 clock macros
In-Reply-To: <9236675.ot3B0M2rgc@avalon>
References: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
 <9236675.ot3B0M2rgc@avalon>
Message-ID: <CANqRtoSYTSZV-wxXBeGWYnPLPGZNL3WEtXgHh1U8CQxAEhx5zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Wolfram, Laurent, everyone,

On Mon, Mar 10, 2014 at 8:36 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Wolfram,
>
> Thank you for the patches.
>
> For the whole series,
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I've now given the patches in this series a spin on top of
renesas-devel-v3.14-rc8-20140325v2.

To clarify, I can't seem to find any cover letter for this series, so
instead I will with this email reply to [1/1]. Here is also a list of
the patches that I believe are part of this series, please correct me
if I'm wrong:

[PATCH V2 1/5] ARM: shmobile: r8a7791: add IIC0/1 clock macros
[PATCH V2 2/5] ARM: shmobile: r8a7791: add IIC(B) clocks to dtsi
[PATCH V2 3/5] ARM: shmobile: r8a7791: add IIC(B) cores to dtsi
[PATCH V2 4/5] ARM: shmobile: koelsch: make i2c2-pfc node unique
[PATCH V2 5/5] ARM: shmobile: koelsch: activate i2c6 bus

They all look good to me!

Acked-by: Magnus Damm <damm@opensource.se>

Simon, can you please pick up these changes? I believe there are no
special dependencies.

Thanks,

/ magnus
