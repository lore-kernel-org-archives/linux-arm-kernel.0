From: smitha.t@samsung.com (Smitha T Murthy)
Date: Tue, 31 Jan 2017 14:42:33 +0530
Subject: [PATCH] [media] s5p-mfc: Align stream buffer and CPB buffer to 512
In-Reply-To: <de7bbdbf-35cc-a575-79d1-2ec5764469a5@samsung.com>
References: <CGME20170118094212epcas5p22e588016d2b330dcd0b99b6e1012c744@epcas5p2.samsung.com>
 <1484732223-24670-1-git-send-email-smitha.t@samsung.com>
 <de7bbdbf-35cc-a575-79d1-2ec5764469a5@samsung.com>
Message-ID: <1485853953.16927.23.camel@smitha-fedora>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-01-18 at 15:37 +0100, Andrzej Hajda wrote: 
> Hi Smitha,
> 
> On 18.01.2017 10:37, Smitha T Murthy wrote:
> > >From MFCv6 onwards encoder stream buffer and decoder CPB buffer
> 
> Unexpected char at the beginning.
> 
> > need to be aligned with 512.
> 
> Patch below adds checks only if buffer size is multiple of 512, am I right?
> If yes, please precise the subject, for example "...CPB buffer size need
> to be...".
> 

Thank you for the review, after further analysis I found this patch is
not required. So I will drop it. 
