From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 7 Nov 2018 14:00:14 -0500
Subject: Weird OOM problem
In-Reply-To: <c685343b-fc12-4933-1749-c5a8716f039d@arm.com>
References: <CAF_dkJB-Z-jU3O95PrE_ToFcOTNdEqMLnPOkzPwBZZfnjyUQwQ@mail.gmail.com>
 <c685343b-fc12-4933-1749-c5a8716f039d@arm.com>
Message-ID: <CAF_dkJCCUp8sHFzGAVELebHOPo6ohuQydNWzUEQ=xigqr1O-SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,
Thank you for your response.
On Wed, Nov 7, 2018 at 11:57 AM Vladimir Murzin <vladimir.murzin@arm.com> wrote:

>
> If you specifies neither "size" nor "nr_blocks" mount option the default
> is 50% of RAM [1].
>
> [1] http://man7.org/linux/man-pages/man5/tmpfs.5.html
>
> Cheers
> Vladimir
>
The tmpfs is sized at 59MB (indeed, 50% of total memory).  This
problem is triggered when I generate a 33MB file in /tmp, which is
awfully close to 25% of my total RAM.  I am busy scouring the internet
and various kernel docs for a parameter set to 25% of total RAM, but
have been unable to find it yet.

Thanks for the tip.  Please keep them coming :-)

--wpd
