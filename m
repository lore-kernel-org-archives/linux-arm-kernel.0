From: ajaynumb@gmail.com (Ajay kumar)
Date: Mon, 2 Feb 2015 14:46:40 +0530
Subject: [PATCH 03/14] drm/bridge: make bridge registration independent of
 drm flow
In-Reply-To: <20150130155927.GO26493@n2100.arm.linux.org.uk>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
 <1421771935-31618-4-git-send-email-ajaykumar.rs@samsung.com>
 <CAF6AEGs8GbgYMLmaPjGnXAv=Gsf6gMhNj+Zt0-2GKHOnHv4d4Q@mail.gmail.com>
 <20150130155927.GO26493@n2100.arm.linux.org.uk>
Message-ID: <CAEC9eQMpRcoJxF_u6rOKw_68x441790r595xdPnBpwqc79AMRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 30, 2015 at 9:29 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 30, 2015 at 10:37:19AM -0500, Rob Clark wrote:
>> On Tue, Jan 20, 2015 at 11:38 AM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
>> I'll also need to update the new bridge in the msm edp code..
>> although that isn't such a big deal if I knew how this was *supposed*
>> to work.. since what is there now at least doesn't look right..
>
> I wonder whether the new dw-hdmi bridge code get fixed up too...
I think its already fixed. Check this:
http://cgit.freedesktop.org/~airlied/linux/commit/?h=drm-next&id=b5217bf4692218d202d3d2cd772864fa1e10be4d

Regards,
Ajay Kumar
