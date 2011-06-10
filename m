From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Jun 2011 23:02:26 +0200
Subject: [PATCH v4 4/4] dt: add amba device creation to platform bus scan
In-Reply-To: <1307738923-7564-5-git-send-email-robherring2@gmail.com>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
	<1307738923-7564-5-git-send-email-robherring2@gmail.com>
Message-ID: <201106102302.26462.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 June 2011 22:48:43 Rob Herring wrote:
> 
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Add support to the platform bus scanning to call custom device creation
> function for amba devices.
> 
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: arnd at arndb.de
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Looks so trivial now ;-)
