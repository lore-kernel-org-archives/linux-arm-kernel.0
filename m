From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 8 Aug 2014 11:43:19 +0200
Subject: [PATCH 2/3] soc/tegra: Use of_match_machine in soc_is_tegra()
In-Reply-To: <1407452515-2390-3-git-send-email-ttynkkynen@nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
 <1407452515-2390-3-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20140808094317.GA15852@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 02:01:54AM +0300, Tuomas Tynkkynen wrote:
> Use the new helper function, also fixing a device_node refcount leak.
> 
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
>  drivers/soc/tegra/common.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140808/18991536/attachment.sig>
