From: ijc@debian.org (Ian Campbell)
Date: Tue, 25 Nov 2014 15:41:52 +0000
Subject: [PATCH] of: support passing console options with stdout-path
In-Reply-To: <CACxGe6vekjF4M0J4s7g2Q_E-KYUrT_3Pna2z6nobSMZ7bc8Bhw@mail.gmail.com>
References: <1416867838-18652-1-git-send-email-leif.lindholm@linaro.org>
 <20141125145854.A46EDC44343@trevor.secretlab.ca>
 <20141125151515.GG2361@bivouac.eciton.net>
 <CACxGe6v2i3iJGjK9s6HSBxV6bUwVrAtGYj=FAOb0AFEx3KVYEg@mail.gmail.com>
 <1416929071.16769.1.camel@debian.org>
 <CACxGe6vekjF4M0J4s7g2Q_E-KYUrT_3Pna2z6nobSMZ7bc8Bhw@mail.gmail.com>
Message-ID: <1416930112.11944.2.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-11-25 at 15:39 +0000, Grant Likely wrote:
> On Tue, Nov 25, 2014 at 3:24 PM, Ian Campbell <ijc@debian.org> wrote:
> >> sed s/of_find_node_by_path\((.*)\)/of_find_node_by_path\(\1, NULL\)
> >
> > Coccinelle rules for this sort of transformation...
> 
> /me still hasn't gotten his head around how to use Coccinelle properly. :-(

Me neither, but for the "add an extra NULL parameter" case I can
generally find something to cargo cult from ;-) (it's been ages since I
had a need though)

Ian.
