From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jan 2012 15:58:53 +0000
Subject: [PATCH 0/6] ux500: Export SoC information and some platform
 clean-up
In-Reply-To: <1327165687-4223-1-git-send-email-lee.jones@linaro.org>
References: <1327165687-4223-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201201231558.53673.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 January 2012, Lee Jones wrote:
> 
> This patch-set satisfies 4 objectives:
>  1. Ensures each platform device can specify a suitable parent
>  2. Provides a bus for SoC devices as a means to export information
>  3. Allows ux500 to make use of the new SoC bus
>  4. Cleans up unnecessary complexity from ux500 code

This version looks good to me, I have no further comments right now.

Greg, can you have another look? I think Lee has addressed all of
my comments as well as yours.

Linus, does this fit with your plans for migrating to only
device-tree based probing for ux500? I guess if this goes in
first, you will have to make a few changes so that it keeps working
when the devices are put into the dts.

Everyone else, who is planning to use the infrastructure besides ux500?

	Arnd
