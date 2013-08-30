From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 30 Aug 2013 13:45:18 +0100
Subject: [PATCH 01/16] Move common EFI stub code from x86 arch code to
 common location
In-Reply-To: <1376402180.27484.12.camel@t520.redhat.com>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-2-git-send-email-roy.franz@linaro.org>
 <1376402180.27484.12.camel@t520.redhat.com>
Message-ID: <20130830124518.68BBA3E102A@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Aug 2013 09:56:20 -0400, Mark Salter <msalter@redhat.com> wrote:
> On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> > No code changes made, just moving functions from x86 arch directory
> > to common location.
> > Code is shared using #include, similar to how decompression code
> > is shared among architectures.
> > 
> > Signed-off-by: Roy Franz <roy.franz@linaro.org>
> > ---
> 
> Tested on arm64.
> 
> Acked-by: Mark Salter <msalter@redhat.com>

Looks okay to me. I'm not a big fan of #including .c files, but I'm okay
with it as-is for the time being. It can be revisited later to
investigate a clean way to compile these functions as a separate .o file.

Reviewed-by: Grant Likely <grant.likely@linaro.org>

g.
