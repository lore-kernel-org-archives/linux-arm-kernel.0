From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 20 Jan 2015 23:44:59 +0100
Subject: [PATCH] checkpatch: Add ability to coalesce commit descriptions
 on multiple lines
In-Reply-To: <1421792716.2724.11.camel@perches.com>
References: <1421659937.9655.16.camel@x220> <1421660338.9655.21.camel@x220>
 <1421792716.2724.11.camel@perches.com>
Message-ID: <1421793899.29393.8.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe, Andrew,

On Tue, 2015-01-20 at 14:25 -0800, Joe Perches wrote:
> If a git commit description is split on consecutive lines,
> coalesce it before testing.
> 
> This allows:
> 
>   commit <foo> ("some long
>   description")
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Noticed-by: Paul Bolle <pebolle@tiscali.nl>

Works as advertised (ie, that particular commit explanation doesn't
trigger an error anymore). And Andrew M. already added it to the -mm
tree.

Thanks, both of you!


Paul Bolle
