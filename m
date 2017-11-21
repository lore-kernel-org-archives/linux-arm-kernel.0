From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Nov 2017 11:53:55 +0000
Subject: [PATCH v2 00/18] Add support for clang LTO
In-Reply-To: <20171120210400.GE89108@samitolvanen.mtv.corp.google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171120152139.mfqthlbneeeiythr@lakrids.cambridge.arm.com>
 <20171120210400.GE89108@samitolvanen.mtv.corp.google.com>
Message-ID: <20171121115354.uo45enssffajv4so@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 01:04:00PM -0800, Sami Tolvanen wrote:
> On Mon, Nov 20, 2017 at 03:21:40PM +0000, Mark Rutland wrote:
> > Would it be possible to split this into:
> > 
> > (1) (basic) arm64 clang support
> > (2) gold support (no LTO)
> > (3) LTO support
> > 
> > ... with any necessary workarounds added as-required to the relevant
> > series?
> 
> Absolutely. I'll split the patches into more sensible sets.

Thanks, that's much appreciated!

Mark.
