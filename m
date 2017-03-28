From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 28 Mar 2017 17:53:30 +0300
Subject: [RFC 6/8] regulator: core: Add regulator_is_bypass function
In-Reply-To: <20170324125506.5cxiykpq2tzzkltb@sirena.org.uk>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <e74c2f4d2b452cbe01aa2a48edde5c024212ffcb.1490199005.git.leonard.crestez@nxp.com>
 <20170324125506.5cxiykpq2tzzkltb@sirena.org.uk>
Message-ID: <1490712810.3546.64.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-24 at 12:55 +0000, Mark Brown wrote:
> On Wed, Mar 22, 2017 at 06:53:08PM +0200, Leonard Crestez wrote:
> > ?/**
> > + * regulator_is_bypass - Determine if the regulator is in bypass mode
> Bypass is a verb so this should be regulator_is_bypassed()

Very well, I will change this.
