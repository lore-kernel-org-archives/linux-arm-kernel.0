From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 06 Apr 2012 21:22:34 -0700
Subject: [PATCH 3/7] of: Add of_property_match_string() to find index into
 a string list
In-Reply-To: <1331680947-29861-4-git-send-email-robherring2@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-4-git-send-email-robherring2@gmail.com>
Message-ID: <20120407042234.1C8093E2FE9@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Mar 2012 18:22:23 -0500, Rob Herring <robherring2@gmail.com> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Add a helper function for finding the index of a string in a string
> list property.  This helper is useful for bindings that use a separate
> *-name property for attaching names to tuples in another property such
> as 'reg' or 'gpios'.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

BTW, this patch got merged for v3.4 so you'll be able to drop it in
the next posting.

g.
