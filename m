From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 19 Feb 2013 09:53:47 -0800
Subject: [patch 1/2] kcmp: Make it to depend on CONFIG_KCMP
In-Reply-To: <20130219093154.GF20312@moon>
References: <20130219064800.719149796@openvz.org>
 <20130219065210.030802820@openvz.org> <5123444D.6000806@suse.cz>
 <20130219093154.GF20312@moon>
Message-ID: <5123BC2B.6000304@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 01:31 AM, Cyrill Gorcunov wrote:
> +
> +	  If unsure, say N.
> +

Wrong advice.  In this particular case, Y is the safe alternative.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
