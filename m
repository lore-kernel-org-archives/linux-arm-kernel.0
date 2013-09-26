From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 26 Sep 2013 23:24:07 +0100
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <1380154255.1974.92@driftwood> (Rob Landley's message of "Wed, 25
 Sep 2013 19:10:55 -0500")
References: <1380154255.1974.92@driftwood>
Message-ID: <yw1xy56jusqg.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Landley <rob@landley.net> writes:

> On 09/25/2013 10:52:44 AM, M?ns Rullg?rd wrote:
>> Rob Landley <rob@landley.net> writes:
>> 
>> > On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
>> >> I'd strongly suggest you make your binutils compatible with newer
>> >> instruction syntax instead of making the kernel more complex.
>> >
>> > Meaning I play whack-a-mole as this becomes permission to depend on
>> > endless new gnuisms just because they're there and nobody else is
>> > regression testing against them, not because they actually add  
>> > anything.
>> 
>> Since when is assembling the instructions correctly, as specified in
>> the arch ref, and not in some other random way a gnuism?
>
> If you require current gnome and drop support for older versions (and  
> implicitly all other desktops), people start writing stuff that depends  
> on systemd. It doesn't matter if the feature you abandoned support for  
> the past 10 years of everthing else for wasn't itself provided by  
> systemd.

Are you saying current binutils depends on gnome and/or systemd?

-- 
M?ns Rullg?rd
mans at mansr.com
