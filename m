From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 18:23:59 +0200
Subject: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
In-Reply-To: <518A73CF.8000309@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <20130508144907.GB20820@mudshark.cambridge.arm.com> <518A73CF.8000309@st.com>
Message-ID: <201305081823.59938.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Stuart MENEFY wrote:
> Fortunately the earliest version of these SoCs uses r2p2, so we avoided that
> particular issue. But as the code doesn't attempt to work around these
> problems a check on the version number might be a good idea to prevent other
> people accidentally hitting it.
> 

Yes, good idea. I would put the version number in the compatible property
and document both the working and non-working versions in the binding,
but put a comment explaining the situation into the driver.

	Arnd
