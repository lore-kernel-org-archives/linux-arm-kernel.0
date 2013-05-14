From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 14 May 2013 14:26:26 -0400
Subject: [PATCH] ARM : omap : remove __init for _enable_preprogram
In-Reply-To: <1368547621-8570-1-git-send-email-jp.francois@cynove.com>
References: <1368547621-8570-1-git-send-email-jp.francois@cynove.com>
Message-ID: <20130514182626.GC32651@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 06:07:01PM +0200, jp.francois at cynove.com wrote:
> _enable_preprogram is marked as __init, but is called from _enable which is not.
> This results in oops once init is freed.
> Fix this by removing the __init marker.
> 
> Signed-off-by: Jean-Philippe Fran?ois <jp.francois@cynove.com>

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
