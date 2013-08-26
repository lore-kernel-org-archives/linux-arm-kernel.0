From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Aug 2013 10:50:38 -0600
Subject: [RFC PATCH 1/3] pinctrl: add new generic pinconf config for
 deglitch filter
In-Reply-To: <1377380109-11247-1-git-send-email-b.brezillon@overkiz.com>
References: <1377379926-11163-1-git-send-email-b.brezillon@overkiz.com>
 <1377380109-11247-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <521B875E.1010605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2013 03:35 PM, Boris BREZILLON wrote:
> Add a new parameter to support deglitch filter configuration.
> A deglitch filter works like a debounce filter but with a smaller
> delay (nanoseconds).

Why not use the existing debounce property, just with a small delay
specified. It seems like that's exactly what the property is for?
