From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 19 Dec 2012 16:41:15 +0000
Subject: [PATCH 3/4 v2] spi: sh-msiof: Add device tree parsing to driver
In-Reply-To: <CABYn4sybRf4vxxGccCDSCEMcza4DZdaZgTD6kZ7+v9CDspzCBg@mail.gmail.com>
References: <1355313289-29769-1-git-send-email-hechtb+renesas@gmail.com>
 <1355313289-29769-3-git-send-email-hechtb+renesas@gmail.com>
 <CABMQnV+CSEKwq=4kQYUDXOuARLA_WgvnkJEME_VeYmAv3PLXBg@mail.gmail.com>
 <CABYn4sybRf4vxxGccCDSCEMcza4DZdaZgTD6kZ7+v9CDspzCBg@mail.gmail.com>
Message-ID: <20121219164115.62A403E0C18@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Dec 2012 12:25:26 +0100, Bastian Hecht <hechtb@gmail.com> wrote:
> Hi Nobuhiro,
> 
> 2012/12/17 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>:
> > Hi, Bastian.
> >
> > On Wed, Dec 12, 2012 at 8:54 PM, Bastian Hecht <hechtb@gmail.com> wrote:
> >> From: Bastian Hecht <hechtb@gmail.com>
> >>
> >> This adds the capability to retrieve setup data from the device tree
> >> node. The usage of platform data is still available.
> >>
> >> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> >> ---

Applied, thanks.

> >> +               .of_match_table = sh_msiof_match,
> >
> > You can use of_match_ptr(sh_msiof_match).
> >
> 
> Ok very nice, will do so.

Please send a fixup patch for this change.

g.
