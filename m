From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Fri, 21 May 2010 11:37:32 +0300
Subject: [PATCH] OMAP: DSS2: storage class should be before const qualifier
In-Reply-To: <1274368372-4043-1-git-send-email-tklauser@distanz.ch>
References: <1274368372-4043-1-git-send-email-tklauser@distanz.ch>
Message-ID: <1274431052.4246.88.camel@tubuntu.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2010-05-20 at 17:12 +0200, ext Tobias Klauser wrote:
> The C99 specification states in section 6.11.5:
> 
> The placement of a storage-class specifier other than at the beginning
> of the declaration specifiers in a declaration is an obsolescent
> feature.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks! Applied to omap-dss tree.

 Tomi
