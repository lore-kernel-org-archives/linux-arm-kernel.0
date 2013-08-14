From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 23:56:44 -0700
Subject: [PATCH 2/2] arm: prima2: pm: drop redundant postcore_initcall
In-Reply-To: <1375175273-14067-2-git-send-email-Baohua.Song@csr.com>
References: <1375175273-14067-1-git-send-email-Baohua.Song@csr.com>
 <1375175273-14067-2-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130814065644.GL19951@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 05:07:53PM +0800, Barry Song wrote:
> This will delete some redundant calling of sirfsoc_of_pwrc_init() and
> sirfsoc_memc_init() for non-CSR platforms if we use multi-platform.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Applied, thanks.

-Olof
