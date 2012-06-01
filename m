From: mturquette@ti.com (Mike Turquette)
Date: Fri, 1 Jun 2012 10:58:46 -0700
Subject: [RFC 00/24] Move OMAP2+ over to use COMMON clock
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Message-ID: <20120601175846.GA23978@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120601-17:37, Rajendra Nayak wrote:
> Hi,
> 
> This RFC series is based of Mikes' latest clk-next. I will
> rebase it once 3.5-rc1 is out and post with more testing thats
> in progress. Meanwhile, the RFC is for me to get some early
> feedback on the patches.
> 
> This series retains the static clock declarations

Hi Rajendra,

Thanks for sending this out.  FYI I'm looking into using bootmem to get
rid of the terrible static init macros.  That's just something to
consider for the future since I do not know when I will have time to
implement that.

Hopefully that change could make it possible to get rid of the static
init macros entirely.  It won't block acceptance of these patches
though.

Regards,
Mike
