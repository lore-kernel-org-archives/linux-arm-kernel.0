From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Sun, 24 Nov 2013 18:40:53 -0500
Subject: ACPI
In-Reply-To: <BB9F4FCA-78FC-4D44-A98E-1C4CE1CFEA7B@jonmasters.org>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <528FC5C1.1080403@jonmasters.org> <528FCEA6.1060602@jonmasters.org>
 <201311231011.45892.arnd@arndb.de>
 <20131123183904.GB20790@obsidianresearch.com>
 <20131123230303.GA5212@srcf.ucam.org>
 <2940EDD8-0EE7-4D61-96F7-3D78D5A52644@jonmasters.org>
 <20131124035651.GA7580@srcf.ucam.org>
 <BB9F4FCA-78FC-4D44-A98E-1C4CE1CFEA7B@jonmasters.org>
Message-ID: <c5032c31-7fa2-495b-8882-025c90535379@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon Masters <jonathan@jonmasters.org> wrote:
>
>On Nov 23, 2013, at 10:56 PM, Matthew Garrett <mjg59@srcf.ucam.org>
>wrote:
>> That seems to be a very verbose way to say "We have no plans to make 
>> sure this is going to work for upstream Linux". I'm disappointed to
>see 
>> Red Hat play along with this.
>
>Matthew, it's a very verbose way to say "this is being worked on". The
>need to get specifications and standards out into public is acutely
>understood. It's something I've been pushing on for many many months,
>and it's something that I expect to see changing soon.  That's really
>all I'm going to say about it for the moment. Meanwhile, I hope that
>the ACPI patches being worked on (very very hard, by very awesome
>people) will be reviewed and considered on their merits.

The track record of vendors adopting solutions and then getting them upstream is significantly worse than that of vendors working with the community and then deploying the negotiated solution. Patches aren't going to be rejected out of hand, but if they satisfy a small number of vendors while compromising the wider kernel then there's a real risk that they won't end up upstream in the desired timescale.

If you're OK taking that risk then I don't think there's anything more to discuss - we'll just wait for the hardware/patches/spec to land and see whether they're reasonable or not. But that's really not the Red Hat way, and it's a shame seeing the company move away from its base. 


-- 
Matthew Garrett | mjg59 at srcf.ucam.org
