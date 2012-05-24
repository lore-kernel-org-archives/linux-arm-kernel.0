From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 24 May 2012 15:19:42 +0100
Subject: [PATCH] Consolidate stack size information into THREAD_SIZE_ORDER
In-Reply-To: <4FBD8205.3010904@am.sony.com>
References: <4FBD8205.3010904@am.sony.com>
Message-ID: <4FBE437E.1060100@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/05/12 01:34, Tim Bird wrote:
> This reduces the number of magic values in the code, as well as
> makes it easier to experiment with larger or smaller stack sizes.
>
> Signed-off-by: Tim Bird<tim.bird@am.sony.com>

Just ran my eyes over it, looks fine.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
