From: davem@davemloft.net (David Miller)
Date: Sat, 26 Oct 2013 01:44:01 -0400 (EDT)
Subject: [PATCH RFC v2 1/4] net: mvmdio: make orion_mdio_wait_ready
 consistent
In-Reply-To: <4955b6b331459b7b9c54350b8f0b254065d013c3.1382637156.git.leigh@solinno.co.uk>
References: <cover.1382199042.git.leigh@solinno.co.uk>
 <cover.1382637156.git.leigh@solinno.co.uk>
 <4955b6b331459b7b9c54350b8f0b254065d013c3.1382637156.git.leigh@solinno.co.uk>
Message-ID: <20131026.014401.2297094945752640834.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leigh Brown <leigh@solinno.co.uk>
Date: Thu, 24 Oct 2013 19:09:31 +0100

> +	        else
> +			if (timedout)
>  				break;
>  

Please make this:

		else if (timedout)
			break;
