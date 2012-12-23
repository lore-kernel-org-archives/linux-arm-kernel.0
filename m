From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Sun, 23 Dec 2012 16:47:36 +0100
Subject: [PATCH 13/15] ARM: AM33XX: Add aes0 crypto clock data
In-Reply-To: <1356107295-11121-14-git-send-email-mgreer@animalcreek.com> (Mark
 A. Greer's message of "Fri, 21 Dec 2012 09:28:13 -0700")
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <1356107295-11121-14-git-send-email-mgreer@animalcreek.com>
Message-ID: <87licou5wn.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Mark" == Mark A Greer <mgreer@animalcreek.com> writes:

 Mark> From: "Mark A. Greer" <mgreer@animalcreek.com>
 Mark> Add clock data for for the SHA0 crypto module

s/SHA/AES/

Reviewed-by: Peter Korsgaard <jacmet@sunsite.dk>
 
 Mark> +static struct clk aes0_fck;
 Mark> +DEFINE_STRUCT_CLK_HW_OMAP(aes0_fck, NULL);
 Mark> +DEFINE_STRUCT_CLK(aes0_fck, dpll_core_ck_parents, clk_ops_null);

-- 
Bye, Peter Korsgaard
