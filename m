From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 8 Aug 2014 11:45:28 +0200
Subject: [PATCH 3/3] cpuidle: big.LITTLE: Use of_match_machine
In-Reply-To: <1407452515-2390-4-git-send-email-ttynkkynen@nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
 <1407452515-2390-4-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20140808094525.GB15852@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 02:01:55AM +0300, Tuomas Tynkkynen wrote:
> Use the new helper function, also fixing a device_node refcount leak.
> 
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
> Compile tested only.
> 
>  drivers/cpuidle/cpuidle-big_little.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140808/d9b58a66/attachment.sig>
