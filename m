From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:09 +0100
Subject: [PATCH v3 00/18] MMP platform fixes
Message-ID: <20181112032027.653931-1-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series contains contains a bunch of MMP2 platform fixes.

I've sent these in before, some as part of other patch sets, but got just
radio silence from MMP2 maintainers. Eric Miao and Haojian Zhuang -- if
you're listening, please speak up.

I'm now re-sending as a single patch set for covenience. The "v3" number
was chosen to be higher than of any of the superseded sets.
The change logs from previous submissions are in respective patches.

The MMP2 support seems to in need for some love. Notably, in absence of
the 12/18 patch, the DT/multiplatform kernels can't even boot. If the
maintainers don't show up, would it be possible to pull this via the arm-soc
tree?  Would it be appropriate if I followed up with a MAINTAINERS update in
that case?

Thanks
Lubo
