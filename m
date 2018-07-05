From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 5 Jul 2018 17:10:48 -0400
Subject: [RFC PATCH 2/5] dt-bindings: xilinx: Add missing zynq boards
In-Reply-To: <20180703230410.GA31330@rob-hp-laptop>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-3-luaraneda@gmail.com>
 <20180703230410.GA31330@rob-hp-laptop>
Message-ID: <CAHbBuxrTSL0B-dC=gh_EOYAvk41mYJq6XsHEnWJi453Fq9Lu3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for reviewing.

On Tue, Jul 3, 2018 at 7:04 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 28, 2018 at 01:42:02AM -0400, Luis Araneda wrote:
> > +- Adapteva Parallella board
> > +  "adapteva,parallella"
>
> This is documented in adapteva.txt, but I'd prefer if you put it
> here and remove adapteva.txt.

Ouch, I should have used git grep to find that.
I'll remove the adapteva.txt file on v2, which I'll be sending later today.

Thanks,

Luis Araneda.
