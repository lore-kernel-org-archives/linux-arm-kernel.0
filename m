From: rfranz@cavium.com (Roy Franz)
Date: Thu, 19 Oct 2017 13:08:19 -0700
Subject: [PATCH] mdt: slram: use memremap() instead of ioremap()
In-Reply-To: <20171019153759.GA26590@infradead.org>
References: <20171017205642.1791-1-roy.franz@cavium.com>
 <20171019153759.GA26590@infradead.org>
Message-ID: <CAKWsp+y87m6N5a1NKasqnny9uOrwDANhgm4bcP6g1ca6yyaDqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 8:37 AM, Christoph Hellwig <hch@infradead.org> wrote:
> s/mdt/mtd/ in the subject?

Yup, I'll repost a fixed version.
