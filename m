From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Aug 2011 20:26:00 +0100
Subject: [RFC][PATCH 1/1 v3] Add Thread Support for the Context ID
	Register of ARM v6 & v7 Architectures
In-Reply-To: <9614a65924d6b53a176c47b9ce1b03625c47e1fd.1311674526.git.wolfgang.betz@st.com>
References: <cover.1311674526.git.wolfgang.betz@st.com>
	<9614a65924d6b53a176c47b9ce1b03625c47e1fd.1311674526.git.wolfgang.betz@st.com>
Message-ID: <20110805192600.GD28958@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can you please not randomly reformat code in a patch which does
material changes to files.

Code reformatting should be a separate patch altogether.  And it should
only be done if it's necessary.  I disagree with a lot of your
reformats, especially the asm() one which changes it from the assembly
instructions being aligned to being just crap.
