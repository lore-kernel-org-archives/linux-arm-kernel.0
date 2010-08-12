From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 12 Aug 2010 10:11:07 +0530
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <4C62C5BD.3020808@mnsu.edu>
References: <4C5F9B25.8080401@st.com>
	<AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>
	<4C624AE1.30504@st.com> <4C62C5BD.3020808@mnsu.edu>
Message-ID: <4C637B63.1060404@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 8/11/2010 9:16 PM, Jeffrey Hundstad wrote:
> Hello,
>
> Exchange 2010 does not handle IMAP "chunking" (partial message transfer) 
> correctly.  Any request after about 1 megabyte of total message size 
> will fail.
>
> Thunderbird uses this "chunking" feature to give you a status update 
> while downloading large messages.  The IMAP statements are of this type:
> 11 UID fetch 244477 (UID RFC822.SIZE BODY[]<20480.12288>)
>
> When the 20480 is larger than 1MB Exchange "claims" there is no more.  
> Sigh....
>
> Fortunately you can disable this feature.  To disable this in 
> Thunderbird you can go to the Advanced configuration and disable the 
> following feature, by setting it to false:
> mail.server.default.fetch_by_chunks
Jeffrey,

I tried this but problem is still there.

viresh.
