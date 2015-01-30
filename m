From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jan 2015 15:59:27 +0000
Subject: [PATCH 03/14] drm/bridge: make bridge registration independent
 of drm flow
In-Reply-To: <CAF6AEGs8GbgYMLmaPjGnXAv=Gsf6gMhNj+Zt0-2GKHOnHv4d4Q@mail.gmail.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
 <1421771935-31618-4-git-send-email-ajaykumar.rs@samsung.com>
 <CAF6AEGs8GbgYMLmaPjGnXAv=Gsf6gMhNj+Zt0-2GKHOnHv4d4Q@mail.gmail.com>
Message-ID: <20150130155927.GO26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 10:37:19AM -0500, Rob Clark wrote:
> On Tue, Jan 20, 2015 at 11:38 AM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
> I'll also need to update the new bridge in the msm edp code..
> although that isn't such a big deal if I knew how this was *supposed*
> to work.. since what is there now at least doesn't look right..

I wonder whether the new dw-hdmi bridge code get fixed up too...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
