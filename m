From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Feb 2014 17:55:39 +0000
Subject: [PATCH v2 1/2] mfd: syscon: Add platform data with a regmap
 config name
In-Reply-To: <1392141165-14338-1-git-send-email-pawel.moll@arm.com>
References: <20140211174829.GJ15081@lee--X1>
 <1392141165-14338-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1392141339.3380.49.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-11 at 17:52 +0000, Pawel Moll wrote:
> +	        const char *label;

Obviously should be a single tab only:

+       const char *label;

Pawel
