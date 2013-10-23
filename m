From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Wed, 23 Oct 2013 18:38:07 +0300
Subject: [Patch v2][ 03/37] drm: Add the lacking DRM_MODE_FLAG_* for
 matching the DISPLAY_FLAGS_*
In-Reply-To: <5267E1D3.5060803@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-4-git-send-email-denis@eukrea.com>
 <20131018074631.GO13047@intel.com> <5267E1D3.5060803@eukrea.com>
Message-ID: <20131023153807.GJ13047@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 04:48:51PM +0200, Denis Carikli wrote:
> Hi,
> 
> On 10/18/2013 09:46 AM, Ville Syrj?l? wrote:
> >> +#define DRM_MODE_FLAG_PDATEN			(1<<22)
> >> +#define DRM_MODE_FLAG_NDATEN			(1<<23)
> >> +#define DRM_MODE_FLAG_PPIXDATEDGE		(1<<24)
> >> +#define DRM_MODE_FLAG_NPIXDATEDGE		(1<<25)
> >
> > Do we really need to make this stuff visible to userspace?
> > And there's no documentation to explain any of it.
> 
> DRM_MODE_FLAG_PDATEN and DRM_MODE_FLAG_NDATEN were meant to represent 
> the data enable polarity.
> 
> DRM_MODE_FLAG_PPIXDATEDGE and DRM_MODE_FLAG_NPIXDATEDGE were meant to 
> represent the clock polarity.
> 
> What would you recommend to represent theses polarities?

I don't really care that much how you represent them. Just wondering
if userspace has any business dictating those, and it not, then they
shouldn't be DRM_MODE flags.

-- 
Ville Syrj?l?
Intel OTC
