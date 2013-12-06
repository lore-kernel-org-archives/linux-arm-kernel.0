From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Dec 2013 10:48:57 -0700
Subject: [PATCH v5 1/3] mfd: tps6586x: add version detection
In-Reply-To: <7812fb79beac0a6a409090f43d129893f9f93b5b.1386333697.git.stefan@agner.ch>
References: <cover.1386333697.git.stefan@agner.ch>
 <7812fb79beac0a6a409090f43d129893f9f93b5b.1386333697.git.stefan@agner.ch>
Message-ID: <52A20E09.7090005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2013 05:51 AM, Stefan Agner wrote:
> Use the VERSIONCRC to determine the exact device version. According to
> the datasheet this register can be used as device identifier. The
> identification is needed since some tps6586x regulators use a different
> voltage table.

FWIW, this version looks good to me now.
