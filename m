From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 5 Nov 2014 17:00:25 +0200
Subject: [PATCH 01/15] [media] Move mediabus format definition to a more
 standard place
In-Reply-To: <5458B407.6050701@cisco.com>
References: <1415094910-15899-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415094910-15899-2-git-send-email-boris.brezillon@free-electrons.com>
 <5458A878.3010809@cisco.com> <20141104114503.309cb54f@bbrezillon>
 <5458B407.6050701@cisco.com>
Message-ID: <20141105150025.GS3136@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 04, 2014 at 12:09:59PM +0100, Hans Verkuil wrote:
> Well, I gave two alternatives :-)
> 
> Both are fine as far as I am concerned, but it would be nice to hear
> what others think.

In fact I think both are good options. :-)

I'd perhaps lean towards the latter, for it has the benefit of pushing to
use the new definitions and the old ones can be deprecated (and eventually
removed in year 2030 or so ;)).

Either way, preprocessor macros should be used instead of an enum since that
way it's possible to figure out at that phase whether something is defined
or not. There is for enums, too, but it results in a compilation error...

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
