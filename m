From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 7 Dec 2017 10:37:05 +0100
Subject: [PATCH RFC 0/4] crypto: engine - Permit to enqueue all async
 requests
In-Reply-To: <4d58a1fc-8577-3fdb-ae6b-e1fade7c6582@st.com>
References: <20171129084121.9385-1-clabbe.montjoie@gmail.com>
 <4d58a1fc-8577-3fdb-ae6b-e1fade7c6582@st.com>
Message-ID: <20171207093705.GB21647@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 10:59:47AM +0000, Fabien DESSENNE wrote:
> Hi Corentin,
> 
> 
> I am fine with this proposal: it is generic enough and I have been able 
> to test and run the crypto engine with aead_request without changing any 
> single line of code.
> 
> This is what I need to be able to send the AEAD extension of the 
> stm32-cryp driver (successfully tested with your engine upgrade proposal).
> 
> 
> I have also tested the stm32-hash patch.
> 
> Note that stm32-cryp (new driver applied by Herbert recently 
> [https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=9e054ec21ef8344345b28603fb272fe999f735db]) 
> would also need to be converted to the new crypto engine API : this is a 
> trivial patch.

Yes, patch for converting it is already done.

> 
> Thank you for your proposal, I hope that this proposal is fine for 
> Herbert too.
> 

Thanks for your test, I hope other maintainer will test it also.

Regards
Corentin Labbe
