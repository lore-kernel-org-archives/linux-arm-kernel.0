From: joe@perches.com (Joe Perches)
Date: Mon, 30 Mar 2015 17:14:48 -0700
Subject: [PATCH 00/25] treewide: Use bool function return values of
 true/false not 1/0
In-Reply-To: <5519E53B.5040504@schaufler-ca.com>
References: <cover.1427759009.git.joe@perches.com>
 <5519E53B.5040504@schaufler-ca.com>
Message-ID: <1427760888.14276.37.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-30 at 17:07 -0700, Casey Schaufler wrote:
> On 3/30/2015 4:45 PM, Joe Perches wrote:
> > Joe Perches (25):
> >   arm: Use bool function return values of true/false not 1/0

[etc...]

> Why, and why these in particular?

bool functions are probably better returning
bool values instead of 1 and 0.

Especially when the functions intermix returning
returning 1/0 and true/false.

(there are only a couple of those though)

These are all the remaining instances in the
kernel tree.
