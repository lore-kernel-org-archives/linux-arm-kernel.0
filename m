From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 25 Jun 2014 15:03:21 +0100
Subject: [RFC PATCH 3/9] irqchip: GIC: Convert to EOImode == 1
In-Reply-To: <CAAhSdy11HQtiOD6XLqQcZ+zf_Z9Mx0nPrJ0ECNNuRkZt=CfdpA@mail.gmail.com>
References: <1403688530-23273-1-git-send-email-marc.zyngier@arm.com>
 <1403688530-23273-4-git-send-email-marc.zyngier@arm.com>
 <CAAhSdy11HQtiOD6XLqQcZ+zf_Z9Mx0nPrJ0ECNNuRkZt=CfdpA@mail.gmail.com>
Message-ID: <1403705001.18068.6.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-06-25 at 19:26 +0530, Anup Patel wrote:
> 
> Ian had send-out a patch long time back to extend
> GIC dt-bindings for addressing this issue.
> (http://www.spinics.net/lists/arm-kernel/msg283767.html)

I've been meaning to revisit this. Since that original patch I've been
wondering if some sort of stride property wouldn't be better.

Ian.
