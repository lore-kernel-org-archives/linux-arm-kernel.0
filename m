From: broonie@kernel.org (Mark Brown)
Date: Sun, 29 Jan 2017 17:50:05 +0000
Subject: [PATCH 2/7] MFD: add STM32 DFSDM support
In-Reply-To: <7b3eb38d-4fd1-2006-7423-94f2a7b38b27@st.com>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <20170124082249.GR16020@dell>
 <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
 <20170124113658.GW16020@dell>
 <a1aaaa20-ac00-b182-f1c1-63152be41135@st.com>
 <20170127101545.g53uah57vgfu55o5@dell>
 <7b3eb38d-4fd1-2006-7423-94f2a7b38b27@st.com>
Message-ID: <20170129175005.2u25l7zd2anlc6tw@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 02:45:49PM +0100, Arnaud Pouliquen wrote:

> Jonathan, Mark, Please could you share your opinion on this topic?

I really don't have enough visbility of what the hardware or software is
doing to say much and though there's extensive backtrace in here it's
not enough to follow.  If it's a generic ADC that happens to have audio
applications then some relationship with IIO might make sense but I
don't know how separate the audio and general purpose bits of the
hardware are.

Please understand that I get copied in on *lots* of threads about MFDs
with drivers getting posted repeatedly for whatever revisions are needed
with little relevance to me so it's very random if I even look at these
things, much less read them with detail.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170129/1d63eeb1/attachment.sig>
