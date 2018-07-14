From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 13 Jul 2018 20:19:23 -0600
Subject: next/master boot: 184 boots: 13 failed, 171 passed (next-20180711)
In-Reply-To: <20180714121046.7a9cdf20@canb.auug.org.au>
References: <5b45f6df.1c69fb81.86409.6375@mx.google.com>
 <20180711145253.GA9651@sirena.org.uk>
 <CAOMZO5B+LBwAEewEoCn=TojQuZ=qMt+4a8n+tiG9cfnzAta_9w@mail.gmail.com>
 <20180712100809.10ac3e1d@canb.auug.org.au>
 <20180714121046.7a9cdf20@canb.auug.org.au>
Message-ID: <1bdd19e5-036d-0979-f360-14a43e3e986d@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/07/18 08:10 PM, Stephen Rothwell wrote:
> I have just imported the new mmotm, and that patch is still in there.
> Has it been fixed, or do I need to remove it again?  (See the above
> patchwork entry).

It has not been fixed. The consensus was to drop it.

@Andrew: I think we should drop the entire series seeing there was
another issue that cropped up earlier today after being in linux-next
(from Guenter Roeck). I will submit an updated v19 when I have a chance.
If you'd like me to handle this in a different way, let me know.

Thanks,

Logan
