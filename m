From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 26 Apr 2015 00:20:58 +0200
Subject: [PATCH v5 0/3] Fix lubbock and mainstone interrupts
In-Reply-To: <1429996403-13644-1-git-send-email-robert.jarzmik@free.fr>
References: <1429996403-13644-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <7247485.mMzWTjWY84@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 25 April 2015 23:13:20 Robert Jarzmik wrote:
> This serie was submitted to the lak list, then migrated to mfd drivers, to end
> up again here. There was no change since last submission. Let's hope this is the
> last spin and that these platform will be fixed at last.
> 

Should these be marked 'Cc: stable at vger.kernel.org'? Can you also add a 'Fixes'
tag with the commit that introduced the problem?

	Arnd
