From: michael.casadevall@linaro.org (Michael Casadevall)
Date: Sat, 22 Mar 2014 19:38:34 -0400
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <532DEB46.3040107@redhat.com>
References: <20140226183454.GA14639@cbox> <20140301152756.67A02C40238@trevor
 .secretlab.ca> <20140306085213.GU643@mal.justgohome.co.uk> <531843EE.
 8040102@redhat.com> <53185FB9.1040308@redhat.com> <20140306120449.GA29916@
 mal.justgohome.co.uk> <20140307122418.2F2C4C408EC@trevor.secretlab.ca> <
 20140322010206.GF25519@cbox> <20140322122354.7644FC418C4@trevor.secretlab.ca>
 <532DEB46.3040107@redhat.com>
Message-ID: <532E1EFA.9000103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 03/22/2014 03:57 PM, Paolo Bonzini wrote:
> Il 22/03/2014 13:23, Grant Likely ha scritto:
>> VM implementations SHOULD to implement persistent variables for 
>> their UEFI implementation - with whatever constraints that may be
>> put on higher level tools. Variable storage SHALL be a property
>> of a VM instance, but SHALL NOT be stored as part of a portable
>> disk image. Portable disk images SHALL conform to the UEFI
>> removable disk requirements from the UEFI spec.
> 
> I fully agree with this wording.
> 
> Paolo

+1 here

Michael
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTLh75AAoJEHM+GkLSJHY5XfwP/27RPv5+UQKgNJa0kooLEGqD
L5YkcofZOPeAdWZ0gzN9BDhzQ+4un5HhaJKTldwgKogblLmaiN9LMi/affSleF+N
HMqSjbxCUy/KduD8Ib4k7qZDkGuO3PbVGP/1RpcaE5jZ+EvQYHGqwRpzWYZyx7Ve
r4DQhSc5IyR8titm/hiCdFufDznQ+afrxuum8WQIC02H3vPYavDmVaApXrgYwnHA
vfSOjEKI4xfmBfWfrtVBFr8/2ZgP9mSuj9lYukun2nRG5Onk7fsPQSZuLCtk52x9
Hx6/hg5hskLM0cTfQ9yCyW3lUdQJkiLmmtn43EfKTJ80esrWpCzhkVD6b4qsYokd
7CpBHziupDTrjQTGundWOkw07pzsrlq3jOQ5tm4hmsr9qwtq4W2SOFfkM2q4KpfO
j0z2edqRoT32v0eAOhBvkC4cx9rfBVZR/sU6HmKqLM80zEMNcXmMfXgwZPqznlfs
bnT342tJPdQD+Mt215MbgKhxwq3kMAWsjW8/2Ad896lyhk6nU0ZbSIc4A8+HBU3M
Bn7tBmpRzuyExsjFxzkhLMfIAa3/UxQuI7o1WXD5asWHxQTKtPhOYTCyhNq4tBHo
8LU9dcP5Q1vZsAFa28MNjrNECf3hrLPxj06NI13CT6PST67FaScMqsV1ZT8Q9xm+
Cw4V5inPq5BvMpdmIu4S
=uG8J
-----END PGP SIGNATURE-----
