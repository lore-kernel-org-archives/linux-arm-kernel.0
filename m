From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 7 Dec 2016 10:41:16 +0100
Subject: Synopsys Ethernet QoS Driver
In-Reply-To: <2eefdb8f-7e87-6009-6e50-c536d4b95dd6@synopsys.com>
References: <20161119135654.GA14079@lnxartpec.se.axis.com>
 <CAJ3bTp7PpUJcz=1JohX=A54UP6vVAafWnB0PGUBSxb5JJiO8Lg@mail.gmail.com>
 <1248f4ce-4859-10e6-fef9-342ea543f8d4@synopsys.com>
 <87c8a24b-0812-7850-cb3f-7be691bab432@st.com>
 <BFA799B0-BB22-4515-AC14-3544A3167B0A@axis.com>
 <ffd3b27c-0bc9-b53b-cc65-c7808595a553@st.com>
 <b126021d-e902-7a53-4d7a-e73ea89a66cf@synopsys.com>
 <A001080B-2DC8-48D9-BD82-8276A9B3BE3D@axis.com>
 <7c7798b5-8cd4-ba99-f526-22d3e06e05db@synopsys.com>
 <2eefdb8f-7e87-6009-6e50-c536d4b95dd6@synopsys.com>
Message-ID: <20161207094116.GA5399@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Thanks!
> 
> Regarding this subject, I am thinking of making the following adaption:
> 
> a) delete ethernet/synopsys
> b) rename ethernet/stmicro/stmmac to ethernet/synopsys
> 
> and send you a patch for you to evaluate. Both agree with the approach?
> To have a new work base would be important, because I will add to the "new"
> structure some missing QoS features like Multichannel support, CBS
> and later TSN.

Rename should be the easy part. Please do that last.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161207/ec5e4ab2/attachment-0001.sig>
