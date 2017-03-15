From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Mar 2017 14:29:28 -0500
Subject: [PATCH v3 3/6] dt-bindings: iio: document interrupt trigger
 support
In-Reply-To: <e6e2f05f-0dc0-f2a3-064b-268776a413c5@kernel.org>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
 <1488300679-3259-4-git-send-email-fabrice.gasnier@st.com>
 <e6e2f05f-0dc0-f2a3-064b-268776a413c5@kernel.org>
Message-ID: <20170315192928.p35tsixaokqxulwq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 05, 2017 at 12:16:28PM +0000, Jonathan Cameron wrote:
> On 28/02/17 16:51, Fabrice Gasnier wrote:
> > Document interrupt trigger that takes a generic interrupt, and
> > can be used as trigger source for sampling devices such as sensors,
> > ADCs...
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> I'm not convinced we want the earlier device tree binding doc at all.
> In the vast majority of cases that chunk on providers is irrelevant.
> What matters is to document the specific case as you have done here.
> 
> So this one I like, the earlier document less so, simply because
> it repeats what this more specific document has described.
> 
> So Rob, what do you think of 'just' this bit?

Yeah, it seems fine. Though, the #io-trigger-cells can be dropped.

Rob
