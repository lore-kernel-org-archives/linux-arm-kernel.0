From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 22 Feb 2016 17:38:52 +0300
Subject: [PATCH 0/6] Support for systems without AArch32 state
In-Reply-To: <56CB1520.8020907@arm.com>
References: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
 <56CB1520.8020907@arm.com>
Message-ID: <20160222143852.GA28180@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 02:03:12PM +0000, Suzuki K. Poulose wrote:
> On 28/01/16 11:32, Suzuki K Poulose wrote:
> >This series add checks to make sure that the AArch32 state is
> >supported before we process the 32bit ID registers. Also
> >checks the same for COMPAT binary execution.
> 
> Yuri,
> 
> Could you please give this series a spin on your hardware ?
> I don't have access to system where I can test this.
> 
> Thanks
> Suzuki

Hi Suzuki,

I can test it in 3-4 days.

Yury
