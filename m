From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Nov 2018 23:50:09 +0800
Subject: [PATCH 01/15] ARM: dts: sun8i-a33: Remove heading 0 in
 video-codec unit address
In-Reply-To: <20181115145013.3378-2-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-2-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v679sG+KqmkGway8E-CdgQa8ybBv8K2RdNwfB7zWAJkaXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> This cosmetic change removes the heading 0 in the video-codec unit
> address, as it's done for other nodes.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Nit: I'd prefer the subject prefix format be "<family>: <soc>: ... ",
or "sun8i: a33:" in this case. This format seems to be used more often
than your alternative format.

I can fix it up when applying.

Acked-by: Chen-Yu Tsai <wens@csie.org>

ChenYu
