From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 26 Apr 2013 16:13:23 +0200
Subject: [PATCH v2] mfd: vexpress: Handle pending config transactions
In-Reply-To: <1366910091-17971-1-git-send-email-pawel.moll@arm.com>
References: <1366821084-12815-1-git-send-email-pawel.moll@arm.com>
 <1366910091-17971-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130426141323.GA4796@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Thu, Apr 25, 2013 at 06:14:51PM +0100, Pawel Moll wrote:
> The config transactions "scheduler" was hopelessly broken,
> repeating completed transaction instead of picking up
> next pending one.
> 
> Fixed now. Also improved debug messages.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/mfd/vexpress-config.c |   35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
Applied and pushed, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
