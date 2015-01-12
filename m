From: dave@sr71.net (Dave Hansen)
Date: Mon, 12 Jan 2015 11:03:58 -0800
Subject: Linux 3.19-rc3
In-Reply-To: <20150112124256.GB13360@arm.com>
References: <20150109121348.GD12942@leverpostej>
 <CAPvkgC23LHhs7Tw4rdAPFooimonji8R7kEAbWYRKPJwouwUzBA@mail.gmail.com>
 <54AFE53A.4020004@redhat.com> <20150109175702.GA27787@leverpostej>
 <54B01FF0.3020900@arm.com> <20150109194333.GA23028@arm.com>
 <54B09CA3.1060501@redhat.com>
 <CA+55aFw3aGeiWOiKxQaC23VVX_Q9B0cDeZc37vVfK+SJVjGwFw@mail.gmail.com>
 <20150110133742.GA6999@arm.com>
 <CA+55aFxBA6F4Kr89iZwPPeBnkiRO4GnrbUSd0CqVG-LD6ZQyiw@mail.gmail.com>
 <20150112124256.GB13360@arm.com>
Message-ID: <54B41A9E.4030705@sr71.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2015 04:42 AM, Will Deacon wrote:
> Since this effectively reverts f045bbb9fa1b, I've added Dave to Cc. It
> should fix the leak without reintroducing the performance regression.

I ran this on the big system that showed the earlier issue.  Everything
seems OK, at least with the test that showed the issue earlier (the brk1
test from will-it-scale).
