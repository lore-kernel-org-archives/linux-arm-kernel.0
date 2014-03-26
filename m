From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 26 Mar 2014 07:29:33 +0100
Subject: [PATCH V2 1/5] ARM: shmobile: r8a7791: add IIC0/1 clock macros
In-Reply-To: <CANqRtoSYTSZV-wxXBeGWYnPLPGZNL3WEtXgHh1U8CQxAEhx5zQ@mail.gmail.com>
References: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
 <9236675.ot3B0M2rgc@avalon>
 <CANqRtoSYTSZV-wxXBeGWYnPLPGZNL3WEtXgHh1U8CQxAEhx5zQ@mail.gmail.com>
Message-ID: <20140326062933.GA2664@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> To clarify, I can't seem to find any cover letter for this series, so
> instead I will with this email reply to [1/1]. Here is also a list of
> the patches that I believe are part of this series, please correct me
> if I'm wrong:

You are absolutely right.

> They all look good to me!
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks!

> Simon, can you please pick up these changes? I believe there are no
> special dependencies.

The dependencies (pfc entries and new compatible for the driver) are
already in linux-next.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140326/5d88e509/attachment.sig>
